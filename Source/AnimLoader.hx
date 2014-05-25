package;

import Loader;
import Sprite;
// import openfl.Tilesheet;

class AnimLoader {

	private var sprites:SheetData;
	private var anims:AnimatorConst;

	public function new(source : String) {
		trace('creating new animation loader...');
		anims 	= Loader.get_anims('ninja');

	}
}