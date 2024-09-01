package com.skilldistillery.howardtreasury.enums;

public enum NotificationType {
    // Achievement and Leveling
    ACHIEVEMENT_UNLOCKED("Achievement Unlocked"),
    LEVEL_UP("Level Up");

    private final String displayName;

    NotificationType(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
