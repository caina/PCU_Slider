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
		
		public function nextSlide(event:MouseEvent):void{
			if(!isVideoPlaing){
				executingPosition++;
				if(videoFiles[executingPosition] == undefined){
					executingPosition = videoFiles.length-1;
				}
				displayMessage(videoFiles[executingPosition]);
				playVideo();			
			}
		}
		
		public function previousSlide(event:MouseEvent):void{
			videoContainer.pauseVideo();
			isVideoPlaing = false;
			_stage.addEventListener(Event.ENTER_FRAME, videoReversePlayBack);
		}
		
		//TODO verificar o THUMBS.mp4
		function loadResources(){
			for (var i = 0; i < filesPathDirectoryList.length; i++) {
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
			
			if(videoContainer !== null){
				videoContainer.unload();
				videoContainer.dispose();
			}
			
			var videoSource = videoFiles[executingPosition][1];
			var use_loop =  videoFiles[executingPosition][2]?-1:0;
			
			_sounds.slideSound(videoFiles[executingPosition][3]);
			
			videoContainer = new VideoLoader(
				videoSource, 
				{
					name:videoSource, 
					container:_stage, 
					width:_stage.stageWidth, 
					height:_stage.stageHeight,
					scaleMode:"stretch", 
					smoothing: true,
					repeat: use_loop,
					autoPlay:false, 
					volume:0
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
			videoContainer.playVideo();
			
		}

		function videoBufferErrorCallBack(event:LoaderEvent):void {
			isVideoPlaing = false;
			displayMessage("error occured with " + event.target + ": " + event.text);
		}

		function videoCompleteCallBack(e:LoaderEvent):void{
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
		
	}
	
}
