<?php
$to = "test@example.com";
$subject = "Test Email via MailHog";
$message = "This is a test email sent to MailHog.";
$headers = "From: sender@example.com";

mail($to, $subject, $message, $headers);
