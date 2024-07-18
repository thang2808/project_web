<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Faculty_Coordinator extends Model
{
    use HasFactory;
    protected $fillable = ['name', 'user_id', 'semester_id', 'description'];

    //User
    function user()
    {
        return $this->belongsTo(User::class);
    }
    //Semester
    public function semester()
    {
            return $this->belongsTo(Semester::class, 'semester_id');
    }
    //Students
    public function students()
    {
        return $this->hasMany(Student::class,'faculty_coordinator_id');
    }
}
