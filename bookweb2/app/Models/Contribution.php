<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Contribution extends Model
{
    use HasFactory, SoftDeletes;
    protected $fillable = ['user_id','faculty_coordinator_id','semester_id','category_id','name','content','upload_file','upload_image', 'thumbnail', 'status','comment', 'popular'];

    public function user(){
        return $this->belongsTo(User::class);
    }

    public function student(){
        return $this->belongsTo(Student::class);
    }

    public function faculty_coordinator(){
        return $this->belongsTo(Faculty_Coordinator::class);
    }

    public function semester(){
        return $this->belongsTo(Semester::class);
    }

    public function category(){
        return $this->belongsTo(Category::class);
    }
}
