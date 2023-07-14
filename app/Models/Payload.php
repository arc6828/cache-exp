<?php

namespace App\Models;

use DOMDocument;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Cache;

class Payload extends Model
{
    use HasFactory;

    public static function fetch($size, $driver = "file",$id)
    {
        // $url = "https://news.google.com/news/rss";
        // $url = url("/payload/dataset-{$size}.json");
        $url = url("https://raw.githubusercontent.com/arc6828/cache-exp/main/public/payload/dataset-{$size}.json?id={$id}");

        $data = Cache::store($driver)->remember($url, now()->addDay(), function () use ($url) {
            //FETCH DATA
            $fileContents = file_get_contents($url);
            return $fileContents;
            // $data = json_decode($fileContents);
            // return $data;
        });

        return $data;
    }

    public static function fetch2($size,$id)
    {
        // $url = "https://news.google.com/news/rss";
        // $url = url("/payload/dataset-{$size}.json");        
        $url = url("https://raw.githubusercontent.com/arc6828/cache-exp/main/public/payload/dataset-{$size}.json?id={$id}");

        $fileContents = file_get_contents($url);
        return $fileContents;
        // $data = json_decode($fileContents);
        // return $data;
    }
}
