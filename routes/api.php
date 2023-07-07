<?php

use App\Models\Medium;
use App\Models\Payload;
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

Route::get('cache/none/{size}',function($size){
    // $data = Medium::fetch2("samkhok","","");
    $data = Payload::fetch2($size);
    // return $data;
    return json_encode($data, JSON_UNESCAPED_UNICODE);
});
  
Route::prefix('cache')->group(function () {
    Route::get('file/{size}',function($size){
        // $data = Medium::fetch("samkhok","","file");
        $data = Payload::fetch($size,"file");
        // return $data;
        return json_encode($data, JSON_UNESCAPED_UNICODE);
    });

    Route::get('memcached/{size}',function($size){
        // $data = Medium::fetch("samkhok","","memcached");
        $data = Payload::fetch($size,"memcached");
        // return $data;
        return json_encode($data, JSON_UNESCAPED_UNICODE);
    });

    Route::get('mysql/{size}',function($size){
        // $data = Medium::fetch("samkhok","","database");
        $data = Payload::fetch($size,"database");
        // return $data;
        return json_encode($data, JSON_UNESCAPED_UNICODE);
    });

    Route::get('redis/{size}',function($size){
        // $data = Medium::fetch("samkhok","","redis");
        $data = Payload::fetch($size,"redis");
        // return $data;
        return json_encode($data, JSON_UNESCAPED_UNICODE);
    });
});

