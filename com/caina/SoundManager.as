/*
Sound managemet 
http://help.adobe.com/pt_BR/ActionScript/3.0_ProgrammingAS3/WS5b3ccc516d4fbf351e63e3d118a9b90204-7d25.html
*/
package com.caina {

	import flash.filesystem.File;
	import flash.events.Event; 
	import flash.events.ProgressEvent; 
	import flash.media.Sound; 
	import flash.net.URLRequest; 
	import flash.media.SoundChannel;
	
	public class SoundManager {
		
		var filesPathDirectoryList: Array = File.applicationDirectory.resolvePath("sound").getDirectoryListing();
		var backgroundFilePath = null;
		var soundsFile:Array = new Array();
		
		var _sound:Sound = null;
		var _soundRequest:URLRequest;
		var _localEventSound:Sound = null;
		var _soundChannel:SoundChannel;
		
		public function SoundManager() {
			loadResources();
		}
		
		function loadResources(){
			for (var i = 0; i < filesPathDirectoryList.length; i++) {
				var fileName = filesPathDirectoryList[i].name.replace("." + filesPathDirectoryList[i].extension, "");
				if(fileName == 'background'){
					backgroundFilePath = "sound/"+fileName+"."+filesPathDirectoryList[1].extension;
				}else{
					var soundFile:Array = new Array();
					soundFile[0] 	= "sound/"+fileName+"."+filesPathDirectoryList[1].extension;
					soundFile[1] 	= fileName;
					soundsFile[i] 	= soundFile;
				}
			}
			playBackground();
		}
		
		private function playSound(filePath:String):void{
			if(_soundRequest !=null && filePath == _soundRequest.url){
				return;
			}
			_sound = getSoundInstance(); 
			_sound.addEventListener(Event.COMPLETE, SoundLoadedCallBack); 
			_soundRequest = new URLRequest(filePath); 
			_sound.load(_soundRequest);
		}

		private function SoundLoadedCallBack(event:Event):void{
			_localEventSound = event.target as Sound; 
			_soundChannel = _localEventSound.play(0,999);
		}
		
		private function playBackground():void{
			if(backgroundFilePath != null){
				playSound(backgroundFilePath);
			}
		}
		
		private function getSoundInstance():Sound{
			if(_sound != null){
				_soundChannel.stop();
				_soundRequest = null;
				_sound.removeEventListener(Event.COMPLETE, SoundLoadedCallBack); 
			}
			return new Sound();
		}
		
		
		/*
			Verifica se nao e um slide sem som, se sim, para a reproducao atual
			Se não, verifica sem existe um audio para aquele slide, se sim, toca
			Se não, toca o background
			@param String do slide
		*/
		public function slideSound(slideName:String):void{
			if (slideName.indexOf("_no_audio") >= 0) {
				getSoundInstance();
				return;
			}
			for(var i =0; i < soundsFile.length; i++){
				if(slideName == soundsFile[i][1]){
					trace("Tocando: "+soundsFile[i][0]);
					playSound(soundsFile[i][0]);
					return;
				}
			}
			playBackground();
		}
	
	}
}
