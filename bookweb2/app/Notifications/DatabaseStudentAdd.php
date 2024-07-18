<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class DatabaseStudentAdd extends Notification
{
    use Queueable;
    public $user;

    /**
     * Create a new notification instance.
     */
    public function __construct($user)
    {
        $this->user = $user;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['database'];
    }

    public function toArray(object $notifiable): array
    {
        return [
            // 'data' => 'Student ' . $this->user->name . ' has added to the system.',
            'user_code' => $this->user->role->code,
            'user_id' => $this->user->id,
            'user_name' => $this->user->name . ' has add new post to your system' ,
            'user_email' => $this->user->email,
            'user_image' => $this->user->profile_photo_path
        ];
    }
}
