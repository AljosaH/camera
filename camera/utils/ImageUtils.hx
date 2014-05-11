package camera.utils;
import flash.display.BitmapData;
import flash.display.JPEGEncoderOptions;
import flash.display.PNGEncoderOptions;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import haxe.io.Bytes;


class ImageUtils
{
    public static inline var FORMAT_JPEG : String = "jpg";
    public static inline var FORMAT_PNG : String = "png";
    
    public static function ConvertBitmapDataToImageData(bitmapData:BitmapData, format:String, quality:Float = 0.9) : Bytes
    {        
        #if flash11_3
        
        var options:Dynamic = (format == FORMAT_JPEG ? new JPEGEncoderOptions(Std.int(quality * 100.0)) : new PNGEncoderOptions());
        var imageData:ByteArray = bitmapData.encode(new Rectangle(0, 0, bitmapData.width, bitmapData.height), options);
        return Bytes.ofData(imageData);
        
        #elseif flash
        
        throw "Unable to convert from BitmapData to JPEG/PNG Bytes in Flash < 11.3. Try <app swf-version=\"11.3\"/>";
        
        #else
        
        var imageData:ByteArray = bitmapData.encode(format, quality);
        return cast(imageData, Bytes);
        
        #end
    }
    
    public static function ConvertImageDataToBitmapData(imageData:Bytes) : BitmapData
    {
        #if flash        		
		var bytes:ByteArray = imageData.getData();
        #else        
        var bytes:ByteArray = ByteArray.fromBytes(imageData);
        #end        
		
        #if flash
        throw "Unable to convert from JPEG Bytes to BitmapData synchronously in flash.";
        #else
        return BitmapData.loadFromBytes(bytes);
        #end
    }
}