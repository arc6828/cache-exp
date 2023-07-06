<?php

use App\Models\Medium;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
Route::get('cache/none',function(){
    $data = Medium::fetch2("samkhok","","");
    return json_encode($data, JSON_UNESCAPED_UNICODE);
});  
Route::prefix('cache')->group(function () {
    Route::get('file',function(){
        $data = Medium::fetch("samkhok","","file");
        return json_encode($data, JSON_UNESCAPED_UNICODE);
    });

    Route::get('memcached',function(){
        $data = Medium::fetch("samkhok","","memcached");
        return json_encode($data, JSON_UNESCAPED_UNICODE);
    });

    Route::get('mysql',function(){
        $data = Medium::fetch("samkhok","","database");
        return json_encode($data, JSON_UNESCAPED_UNICODE);
    });

    Route::get('redis',function(){
        $data = Medium::fetch("samkhok","","redis");
        return json_encode($data, JSON_UNESCAPED_UNICODE);
    });
});

