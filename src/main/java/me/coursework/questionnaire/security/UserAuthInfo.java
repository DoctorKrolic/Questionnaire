package me.coursework.questionnaire.security;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;

@Data
@AllArgsConstructor
public class UserAuthInfo implements UserDetails {
    @Setter(AccessLevel.NONE)
    private long id;
    private String login;
    private String passwordHash;
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() { return new ArrayList<>(); }

    @Override
    public String getPassword() { return passwordHash; }

    @Override
    public String getUsername() { return login; }

    @Override
    public boolean isAccountNonExpired() { return true; }

    @Override
    public boolean isAccountNonLocked() { return true; }

    @Override
    public boolean isCredentialsNonExpired() { return true; }

    @Override
    public boolean isEnabled() { return true; }
}