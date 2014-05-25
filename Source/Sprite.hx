package;

import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.geom.Point;
import openfl.display.Tilesheet;
import openfl.Assets;

class SpriteData extends Rectangle {

	public var name:String;

	public function new(?_name, ?_x, ?_y, ?_width, ?_height) {
		super(_x, _y, _width, _height);
		name = _name;
	}
	
}

class SheetData {
	public var name:String;
	public var data:Map<String, SpriteFolder>;

	public function new(_name, _data) {
		name = _name;
		data = _data;
	}
}

class SpriteFolder {
	public var name:String;
	public var sprites:Map<String, SpriteData>;

	public function new(_name, _sprites) {
		name 	= _name;
		sprites = _sprites;
	}
}

class AnimData {
	public var name:		String;
	public var loops: 		Bool;
	public var frame_map:	Array<Frame>;

	public function new(_name, _loops, _frame_map) {
		name 		= _name;
		loops 		= _loops;
		frame_map 	= _frame_map;
	}

	private function create_tiles() { 

	}
}

class Frame {

	public var index:		Int;
	public var delay:		Int;
	public var cell_map: 	Array<Cell>;

	public function new(_index, _delay, _cell_map) {
		index 		= _index;
		delay 		= _delay;
		cell_map 	= _cell_map;
	}
}

class Cell extends Point {

	public var name:	String;
	public var z: 		Int;

	public function new(_name, _x, _y, _z=0){
		super(_x, _y);
		name = _name; z = _z;
	}
}

class AnimatorConst{

	public var sheetSource	:SheetData;
	public var version 		:String;
	public var anims 		:Map<String,Dynamic>;
	public var animator 	:Animator;

	public function new(_bitmap, _sheet, _ver, _anims) {

		animator = new Animator(Assets.getBitmapData('assets/' + _bitmap));

		sheetSource 	= _sheet;
		version 		= _ver;
		anims 			= _anims;

		load_anim_tiles();
	}

	private function load_anim_tiles() {
		// trace(sheetSource.data["ninja_mode"].sprites);
		for(anim in anims.iterator()) {
			parse_frames(anim.frame_map);
		}

	}

	private function parse_frames(frames : Array<Dynamic>) {

		for(frame in frames.iterator()) {
			
			var cells = parse_cells(frame.cell_map);
		}
	}

	private function parse_cells(cells : Array<Dynamic>) : Array <Int> {
		var cell_list = new Array();
		for(cell in cells.iterator()) {
			var geom = find_sprite(cell.name);
			var tile_index = animator.rect(new Rectangle(0,0,50,50), new Point(cell.x, cell.y));
			cell_list.push(tile_index);
		}

		return cell_list;
	}

	private function find_sprite(location : String) : SpriteData {
		var folders = location.split('/');
		return sheetSource.data[folders[1]].sprites[folders[2]];
	}
}

class Tile {
	public var dur: 	Int;
	public var cells:	Array<Int>;

	public function new (_dur, _cells) {
		dur 	= _dur;
		cells 	= _cells;
	}
}

class Animator extends Tilesheet {

	private var animation_list 	:Array<Animation>;

	public function new(_bitmap) {

		super(_bitmap);
	}

	public function rect(square, point) : Int{
		trace(square, point);
		return addTileRect(square, point);
	}

}

class Animation {

	private var frame_list: 	Array<Tile>;
	private var timer: 			Int;
	private var current_frame: 	Int;

	public function new(_frame_list, starting_frame=0) {
		frame_list 		= _frame_list;
		timer 			= 0;
		current_frame 	= starting_frame;
	}

	public function get_current_frame() return frame_list[current_frame];

	public function increment_frame() current_frame++;
} 