<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Student extends Model
{
    use HasFactory;
    protected $fillable = ['user_id' ,'faculty_coordinator_id'];

    public function user(){
        return $this->belongsTo(User::class);
    }

    public function faculty_coordinator(){
        return $this->belongsTo(Faculty_Coordinator::class);
    }
}
