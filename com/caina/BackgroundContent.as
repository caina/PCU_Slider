package com.caina {
	
	import flash.events.Event;
	import flash.display.*;
	import flash.net.URLRequest;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.IOErrorEvent;
	import flash.media.Video;
	import com.greensock.loading.VideoLoader;

	public class BackgroundContent {
		
		var _stage;
		var _background_image:Bitmap;		
		var screenShotVideobitmap:Bitmap;
		var _loader:Loader = new Loader();
		var screenShotVideobitmapData:BitmapData = null;
		
		public function BackgroundContent(stage) {
			_stage = stage;
			drawBackground();
		}
		
		private function draw(event:Event){
			_background_image = Bitmap(_loader.content);
			_stage.addChildAt(_background_image,0);
			_background_image.x = (_stage.width/2 );
			_background_image.x = (_stage.height/2 - 100);
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,draw);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,errorBackgroundCallBack);
		}
		
		private function errorBackgroundCallBack(event:Event):void{
			trace("Background not found");
		}
		
		private function removeBackgroundImage(){
			if(_background_image != null){
				_stage.removeChild(_background_image);
				_background_image = null;
			}
		}
		/*
			We expect here a VideoLoader to take a raw content, it would be better if i could
			pass just a bitmap, but it wont work, if i figure out how to make it i impruve this method
		*/
		function takeVideoPrintCreen(imageRaw:VideoLoader):void{
			if(screenShotVideobitmap == null){
				screenShotVideobitmap = new Bitmap(screenShotVideobitmapData = new BitmapData(_stage.width, _stage.height, false, 0x00FFFFFF), "auto", true);
				_stage.addChildAt(screenShotVideobitmap, 0);
			}
			removeBackgroundImage();
			screenShotVideobitmapData.draw(imageRaw.rawContent);
			trace("Background Alterado");
		}
		
		function drawBackground():void{
			_loader.load(new URLRequest("background.png"));
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,draw);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,errorBackgroundCallBack);
		}

	}
}
