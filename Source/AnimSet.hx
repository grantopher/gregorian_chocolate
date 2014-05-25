package;

import flash.display.Sprite;

class AnimSet extends Sprite {

	private var set_map:Map<String, Dynamic>;
	private var file_source:String;

	public function new(source : String) {
		super();
		file_source = source;		
		construct();

	}

	private function construct() {
		var loader = new AnimLoader(file_source);
		// set_map = loader.get_anim_map();
	}

}