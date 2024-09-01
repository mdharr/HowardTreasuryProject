package com.skilldistillery.howardtreasury.enums;

public enum NotificationType {
    ACHIEVEMENT_UNLOCKED("Achievement Unlocked"),
    LEVEL_UP("Level Up");

    private final String displayName;

    NotificationType(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }

    public static NotificationType fromDisplayName(String displayName) {
        for (NotificationType type : values()) {
            if (type.getDisplayName().equals(displayName)) {
                return type;
            }
        }
        throw new IllegalArgumentException("No enum constant with display name: " + displayName);
    }
}
