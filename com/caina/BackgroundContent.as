package com.caina {
	

	
	public class BackgroundContent {
		
		var _stage;
		
		public function BackgroundContent(stage) {
			_stage = stage;
			
			
			loader.load(new URLRequest("background.png"));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeBackgroundImageCallBack);
			//loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,function(){displayMessage("nenhum bg encontrado")});

		}
		
		private function draw(){
			
		}
		
		

	}
	
}
