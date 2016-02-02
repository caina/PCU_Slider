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
		var _sounds = new SoundManager();
		
		public function SlideManager(stage) {
			_stage = stage;
			loadResources();
		}
		
		
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


			for (var t: Object in videoFiles)
				displayMessage(t + " : " + videoFiles[t])


		}
		
		
		/*
		Deveria fazer os frames irem de tras pra frente, not going to happen :(

		vou deixar isso pra mais tarde
		*/
		var speed:Number = 0.001;
		var currentVideoTime:Number = 0;
		function reverseVideo(e:Event):void{
			displayMessage("rebobinando!");
			if(videoContainer != null){
				
				
				displayMessage("a: "+videoContainer.videoTime+" d: "+videoContainer.duration + " v: "+(videoContainer.duration - videoContainer.videoTime));	
				if(videoContainer.duration - videoContainer.videoTime < (videoContainer.duration-0.2)){
					
					//currentVideoTime -= speed;
					videoContainer.videoTime = videoContainer.videoTime - speed;
					videoContainer.playVideo();
					videoContainer.pauseVideo();
				}else{
					displayMessage("Voltou para "+executingPosition);
					executingPosition--;
					isVideoPlaing = false;
					videoContainer.videoTime = 0.46;
					//removeEventListener(Event.ENTER_FRAME, reverseVideo);
				}
			}
		}
		
		function previousSlideHandle(event:MouseEvent){
			videoContainer.pauseVideo();
			//addEventListener(Event.ENTER_FRAME, reverseVideo);
			if(executingPosition >=1){
				
			}
		}

		function nextSlideHandle(event:MouseEvent){
			if(!isVideoPlaing){
				executingPosition++;
				displayMessage(videoFiles[executingPosition]);
				if(videoFiles[executingPosition] == undefined){
					executingPosition = videoFiles.length;
				}
				playCurrentVideo();			
			}
		}


		function playCurrentVideo():void{
			
			displayMessage("Reproduzindo: "+videoFiles[executingPosition][1]);
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
					//bgColor:0x000000, 
					autoPlay:false, 
					volume:0
					//requireWithRoot:this.root
				}
			);
					
			VideosQueue = new LoaderMax({name:"mainQueue",  onComplete:videoBufferCompleteCallBack, onError:videoBufferErrorCallBack});
			VideosQueue.append( videoContainer );
			
			videoContainer.load(true);
			VideosQueue.load(true);
			
			videoContainer.addEventListener(VideoLoader.VIDEO_COMPLETE,videoCompleteCallBack,false,0,true);
			videoContainer.addEventListener(VideoLoader.PLAY_PROGRESS , videoProgressCallBack);
			
		}

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
			
			//createPrintScreen();
		}

		function videoProgressCallBack(e:LoaderEvent):void{
			
		}

		function displayMessage(message:String):void{
			trace(message);
		}

	}
	
}
