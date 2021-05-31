package me.coursework.questionnaire.services;

import me.coursework.questionnaire.dto.PasswordChangeDTO;
import me.coursework.questionnaire.dto.ProfileDTO;
import me.coursework.questionnaire.dto.RegisterDTO;
import me.coursework.questionnaire.models.User;
import me.coursework.questionnaire.repositories.UserRepository;
import me.coursework.questionnaire.security.SecurityUtils;
import me.coursework.questionnaire.security.UserAuthInfo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.Optional;

@Service
public class UserService implements UserDetailsService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    @Value("${password.min-length}")
    private int passwordMinLength;

    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public void register(RegisterDTO registerDTO, Model model) {
        String login = registerDTO.getLogin();
        String password = registerDTO.getPassword();
        String passwordRepeat = registerDTO.getPasswordRepeat();
        if (userRepository.existsByLogin(login)) {
            model.addAttribute("msgType", "loginExists");
            return;
        }
        if (password.length() < passwordMinLength) {
            model.addAttribute("msgType", "tooShortPassword");
            return;
        }
        if (!password.equals(passwordRepeat)) {
            model.addAttribute("msgType", "passwordsNotSame");
            return;
        }
        User user = new User(login, passwordEncoder.encode(password), registerDTO.getFirstName(), registerDTO.getLastName());
        userRepository.save(user);
        model.addAttribute("msgType", "registered");
    }

    public void getProfile(Model model) {
        UserAuthInfo authInfo = SecurityUtils.getAuthentication();
        User user = userRepository.findById(authInfo.getId()).get();
        String firstName = user.getFirstName();
        String lastName = user.getLastName();
        model.addAttribute("login", user.getLogin());
        model.addAttribute("firstName", firstName);
        model.addAttribute("lastName", lastName);
        model.addAttribute("fullName", user.getFullName());
    }

    public void changeProfile(ProfileDTO profileDTO, Model model) {
        UserAuthInfo authInfo = SecurityUtils.getAuthentication();
        User user = userRepository.findById(authInfo.getId()).get();
        user.setFirstName(profileDTO.getFirstName());
        user.setLastName(profileDTO.getLastName());
        String newLogin = profileDTO.getLogin();
        if (!newLogin.equals(user.getLogin())) {
            if (userRepository.existsByLogin(newLogin)) {
                model.addAttribute("msgType", "loginExists");
            } else {
                user.setLogin(newLogin);
                authInfo.setLogin(newLogin);
            }
        }
        if (!model.containsAttribute("msgType")) model.addAttribute("msgType", "success");
        userRepository.save(user);
        getProfile(model);
    }

    public void getChangePassword(Model model) {
        UserAuthInfo authInfo = SecurityUtils.getAuthentication();
        User user = userRepository.findById(authInfo.getId()).get();
        model.addAttribute("fullName", user.getFullName());
    }

    public void changePassword(PasswordChangeDTO passwordChangeDTO, Model model) {
        UserAuthInfo authInfo = SecurityUtils.getAuthentication();
        User user = userRepository.findById(authInfo.getId()).get();
        model.addAttribute("fullName", user.getFullName());
        if (!passwordEncoder.matches(passwordChangeDTO.getOldPassword(), user.getPasswordHash())) {
            model.addAttribute("msgType", "wrongOldPassword");
            return;
        } else if (passwordChangeDTO.getNewPassword().length() < passwordMinLength) {
            model.addAttribute("msgType", "tooShortNewPassword");
            return;
        }
        String hash = passwordEncoder.encode(passwordChangeDTO.getNewPassword());
        authInfo.setPasswordHash(hash);
        user.setPasswordHash(hash);
        userRepository.save(user);
        model.addAttribute("msgType", "success");
    }

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        Optional<User> userOpt = userRepository.findByLogin(s);
        if (userOpt.isEmpty()) throw new UsernameNotFoundException("User with login " + s + " was not found");
        return userOpt.get().getAuthInfo();
    }
}