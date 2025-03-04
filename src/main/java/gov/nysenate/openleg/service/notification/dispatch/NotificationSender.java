package gov.nysenate.openleg.service.notification.dispatch;

import gov.nysenate.openleg.model.notification.NotificationDigest;
import gov.nysenate.openleg.model.notification.NotificationMedium;
import gov.nysenate.openleg.model.notification.NotificationSubscription;
import gov.nysenate.openleg.model.notification.RegisteredNotification;

import java.util.Collection;

public interface NotificationSender {

    /**
     * @return The medium through which the sender sends notifications
    */
    NotificationMedium getTargetType();

    /**
     * Sends a notification to all of the given subscriptions
     * @param registeredNotification Notification
     * @param subscriptions Collection<NotificationSubscription>
     */
    void sendNotification(RegisteredNotification registeredNotification, Collection<NotificationSubscription> subscriptions);

    /**
     * Formats and sends the given notification digest
     */
    void sendDigest(NotificationDigest digest);
}
