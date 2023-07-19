<?php

namespace App\Models;

use DOMDocument;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Cache;

class Payload extends Model
{
    use HasFactory;

    public static function fetch($size, $driver = "file", $id)
    {
        // $url = "https://news.google.com/news/rss";
        // $url = url("/payload/dataset-{$size}.json");
        $url = "https://raw.githubusercontent.com/arc6828/cache-exp/main/public/payload/dataset-{$size}.json?id={$id}";

        $data = Cache::store($driver)->remember($url, now()->addDay(), function () use ($url) {
            //FETCH DATA
            $fileContents = file_get_contents($url);
            return $fileContents;
            // $data = json_decode($fileContents);
            // return $data;
        });

        return $data;
    }

    public static function fetch2($size, $id)
    {
        // $url = "https://news.google.com/news/rss";
        // $url = url("/payload/dataset-{$size}.json");        
        $url = "https://raw.githubusercontent.com/arc6828/cache-exp/main/public/payload/dataset-{$size}.json?id={$id}";

        $fileContents = file_get_contents($url);
        return $fileContents;
        // $data = json_decode($fileContents);
        // return $data;
    }
    public static function fetch3($size, $id)
    {
        // $url = "https://news.google.com/news/rss";
        $url = url("/payload/dataset-{$size}.json");
        // $url = url("https://raw.githubusercontent.com/arc6828/cache-exp/main/public/payload/dataset-{$size}.json?id={$id}");
        // $filename = public_path()."/payload/dataset-{$size}.json";
        // $myfile = fopen($filename, "r") or die("Unable to open file!");
        // $fileContents = fread($myfile, filesize($filename));
        // fclose($myfile);
        $fileContents = file_get_contents($url);
        return $fileContents;
        // $data = json_decode($fileContents);
        // return $data;
    }

    public static function test($size,$driver, $id)
    {
        $num_requests = $id;
        $url = "https://raw.githubusercontent.com/arc6828/cache-exp/main/public/payload/dataset-{$size}.json?id={$id}";
        $start = microtime(true);
        foreach (range(1, $num_requests) as $item) {
            // Cache::store('redis')->get('users');
            $data = Cache::store($driver)->remember($url, now()->addDay(), function () use ($url) {
                //FETCH DATA
                $fileContents = file_get_contents($url);
                return $fileContents;
                // $data = json_decode($fileContents);
                // return $data;
            });
        }
        $result = microtime(true) - $start;
        $json = [
            "driver" => $driver,
            "size" => $size,
            "url" => $url,
            "duration_seconds" => $result,
            "samples" => $num_requests,
        ];
        return $json;
        // dump($result);
    }
}
