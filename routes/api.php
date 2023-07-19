<?php

use App\Http\Controllers\API\CacheController;
use App\Http\Controllers\API\CacheFlushController;
use App\Models\Medium;
use App\Models\Payload;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Route;
// Cache::store('redis')->rememberForever('users', fn () => User::factory()->count(100)->make());
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

Route::prefix('cache')->group(function () {
    Route::get('flush/{driver?}', [CacheFlushController::class, "flush"]);
    Route::get('none/{size}/{id?}', [CacheController::class, "none"]);
    Route::get('file/{size}/{id?}', [CacheController::class, "file"]);
    Route::get('mysql/{size}/{id?}', [CacheController::class, "mysql"]);
    Route::get('redis/{size}/{id?}', [CacheController::class, "redis"]);
    Route::get('json/{size}/{id?}', [CacheController::class, "json"]);
    Route::get('test/{driver}/{size}/{id?}', [CacheController::class, "test"]);
});
