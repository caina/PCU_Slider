/*

	HANDLE ALL THE VIDEOS FUNCTIONS
	USING GREENSOCK LIBRARY, WE ARE
	ABLE TO STREAM LOCAL FILES
	
	CLASS UNDER CONSTRUCTIONS

*/
package com.caina {
	
	import flash.filesystem.File;
	import flash.events.VideoEvent;
	import flash.media.StageVideo;
	
	import flash.events.Event; 
	import flash.events.MouseEvent;
	import com.greensock.loading.*;
	import com.greensock.loading.display.*;
	import com.greensock.*;
	import com.greensock.events.LoaderEvent;

	import com.caina.SoundManager;
	import com.caina.BackgroundContent;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import fl.transitions.Wipe;
	import flash.utils.setTimeout;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	
	public class SlideManager {

		var filesPathDirectoryList: Array = File.applicationDirectory.resolvePath("content").getDirectoryListing();
		var videoFiles: Array = new Array();
		var videoFile: Array = new Array();
		var videoFileName:String;
		var VideosQueue:LoaderMax;

		
		var _stage;
		var isVideoPlaing:Boolean = false;
		
		var executingPosition:int = 1;
		var videoContainer:VideoLoader;
		var _background:BackgroundContent;
		var _sounds = new SoundManager();
		
		public function SlideManager(stage) {
			_stage = stage;
			loadResources();
			_background = new BackgroundContent(stage);
		}
		
		public function forceNextSlide(event:MouseEvent):void{
			if(isVideoPlaing){
				_background.takeVideoPrintCreen(videoContainer);
				pauseVideo();			
				_next();
			}
		}
		
		public function toggle_sounds(operation:int):void{
			_sounds.toggle_stop_sound(operation);
		}
		
		public function nextSlide(event:Event):void{
			if(!isVideoPlaing){
				_next();
			}
		}
		
		private function _play_action():void{
			executingPosition++;
			if(videoFiles[executingPosition] == undefined){
				executingPosition = videoFiles.length-1;
			}
			//displayMessage(videoFiles[executingPosition]);
			playVideo();
		}
		
		public function previousSlide(event:Event):void{
			//pauseVideo();
			isVideoPlaing = false;
			executingPosition--;
			if(videoFiles[executingPosition] === undefined){
				executingPosition = 1;
			}
			playVideo();
		}
		
		function loadResources(){
			for (var i = 0; i < filesPathDirectoryList.length; i++) {
				if(filesPathDirectoryList[i].extension != 'mp4'){
					continue;
				}
				
				videoFileName = filesPathDirectoryList[i].name.replace("." + filesPathDirectoryList[i].extension, "");
				videoFile = new Array();
				videoFile[0] = executingPosition;
				videoFile[1] = "content/"+videoFileName+"."+filesPathDirectoryList[1].extension;//files[i].nativePath;
				videoFile[2] = (videoFileName.indexOf("L") >= 0);
				videoFile[3] = videoFileName;
				videoFiles[executingPosition] = videoFile;
				executingPosition++;
			}
			executingPosition = 0;
		}
		
		function playVideo():void{
			
			if(videoFiles[executingPosition] === undefined){
				return;
			}
			
			var videoSource = videoFiles[executingPosition][1];
			var use_loop =  videoFiles[executingPosition][2]?-1:0;
			
			_sounds.slideSound(videoFiles[executingPosition][3]);

			if(videoContainer != null){
				videoContainer.unload();
				//videoContainer.dispose(); n sei porque n rolou 
			}
			
			videoContainer = new VideoLoader(
				videoSource, 
				{
					name:videoSource, 
					container:_stage, 
					width:_stage.stageWidth,
					height:_stage.stageHeight,
					smoothing: true,
					//scaleMode:"heightOnly",
					vAlign:'left',
					hAlign:'left',
					x:0,
					y:0,
					repeat: use_loop,
					autoPlay:false, 
					volume:0,
					noCache:true
				}
			);
			
			VideosQueue = new LoaderMax({name:"mainQueue",  onComplete:videoBufferCompleteCallBack, onError:videoBufferErrorCallBack});
			VideosQueue.append( videoContainer );
			
			videoContainer.load(true);
			VideosQueue.load(true);
			
			videoContainer.addEventListener(VideoLoader.VIDEO_COMPLETE,videoCompleteCallBack,false,0,true);
			videoContainer.addEventListener(VideoLoader.PLAY_PROGRESS , videoProgressCallBack);
		}
		
		/**
		Runs at the enter frame, the idea is stop the current video, and play it backwards
		
		tem que voltar dois videos, isso e inviavel n?
		*/
		function videoReversePlayBack(event:Event):void{
			if(videoContainer != null){
				if(videoContainer.duration - videoContainer.videoTime < videoContainer.duration){
					videoContainer.gotoVideoTime((videoContainer.videoTime - 0.002));
					displayMessage(videoContainer.videoTime+" ");
				}else{
					_stage.removeEventListener(Event.ENTER_FRAME, videoReversePlayBack);
				}
			}
		}
		
		/**
			CALLBACK HANDLES
		*/
		function videoBufferCompleteCallBack(event:LoaderEvent):void {
			isVideoPlaing = true;
			//createPrintScreen();
			if(videoContainer != null){
				videoContainer.playVideo();
			}
		}

		function videoBufferErrorCallBack(event:LoaderEvent):void {
			isVideoPlaing = false;
			displayMessage("error occured with " + event.target + ": " + event.text);
		}

		function videoCompleteCallBack(e:LoaderEvent):void{
			displayMessage("finalizado");
			isVideoPlaing = false;
			videoContainer.removeEventListener(VideoLoader.VIDEO_COMPLETE,videoCompleteCallBack);
			videoContainer.removeEventListener(VideoLoader.PLAY_PROGRESS,videoProgressCallBack);
			_background.takeVideoPrintCreen(videoContainer);
		}

		function videoProgressCallBack(e:LoaderEvent):void{
			
		}
				
		function ErrorPlayerHandle():void{}
		
		private function displayMessage(_message:String){
			trace(_message);
		}
		private function pauseVideo():void{
			if(videoContainer != null){
				videoContainer.pauseVideo();
			}
		}
		
		public function _next():void{
			setTimeout(_play_action, 200);
		}
		
	}
	
}
