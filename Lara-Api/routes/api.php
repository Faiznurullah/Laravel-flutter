<?php

use App\Http\Controllers\api\userscontroller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('user', [userscontroller::class, 'get']);
Route::get('user/{id}', [userscontroller::class, 'get']);
Route::post('user', [userscontroller::class, 'store']);
Route::put('user/{id}', [userscontroller::class, 'update']);
Route::delete('user/{id}', [userscontroller::class, 'destroy']);