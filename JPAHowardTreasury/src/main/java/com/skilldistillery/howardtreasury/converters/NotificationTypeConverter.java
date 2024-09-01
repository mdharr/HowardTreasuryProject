package com.skilldistillery.howardtreasury.converters;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

import com.skilldistillery.howardtreasury.enums.NotificationType;

@Converter(autoApply = true)
public class NotificationTypeConverter implements AttributeConverter<NotificationType, String> {

    @Override
    public String convertToDatabaseColumn(NotificationType attribute) {
        return attribute != null ? attribute.getDisplayName() : null;
    }

    @Override
    public NotificationType convertToEntityAttribute(String dbData) {
        return dbData != null ? NotificationType.fromDisplayName(dbData) : null;
    }
}
