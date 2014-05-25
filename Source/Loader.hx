package;

import openfl.Assets;
import haxe.Json;
import Sprite;

class Loader {
	

	public static function get_sprites(source : String) : SheetData {
		var string 		= get_data_asset(source, 'sprites');
		var json 		= Json.parse(string);
		var spt_name 	= json.name;
		var def 		= json.definitions; def[0]; // json has to be declared..
		var spt_folder:Map<String, SpriteFolder>  = parse_sprite_folders(def[0].dir);
		var map 		= new SheetData(spt_name, spt_folder);

		trace(spt_folder);

		return map;

	}

	public static function parse_sprite_folders(folder_list : Dynamic) : Map<String, SpriteFolder> {
		folder_list[0]; // json array has to be declared..
		var folder_map:Map<String, SpriteFolder> = new Map();

		for(f in 0...folder_list.length) { 
			var folder = folder_list[f];
			var folder_data = new SpriteFolder(folder.name, parse_sprite_sprites(folder.spr));
			folder_map.set(folder.name, folder_data);
		}

		return folder_map;
	}

	public static function parse_sprite_sprites(folder : Array<Dynamic>) : Map<String, SpriteData> {
		var sprite_map:Map<String, SpriteData> = new Map();

		for(s in 0...folder.length){
			var spr_dta 	= folder[s];
			var sprite 		= new SpriteData(spr_dta.name, spr_dta.x, spr_dta.y, spr_dta.w, spr_dta.h);
			sprite_map.set(spr_dta.name, sprite);
		}

		return sprite_map;
	}

	//	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--
	//	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--
	//	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--	--


	public static function get_anims(source : String) : AnimatorConst {
		var string 		= get_data_asset(source, 'anim');
		var json 		= Json.parse(string);

		var sheet 		= json.spriteSheet;
		var sprite_data = get_sprites(sheet);
		var ver 		= json.ver;
		var anims 		= parse_anims(json.anims);

		var animation  	= new AnimatorConst('runner_sprite.png', sprite_data, ver, anims);
		return animation;
	}

	public static function parse_anims(anim_list : Array<Dynamic>) : Map<String, AnimData> {
		anim_list[0];
		var anim_map = new Map();

		for(anim in anim_list.iterator()) {
			var frame_map 	= parse_anim_frms(anim.cells);
			var anim_data 	= new AnimData(anim.name, anim.loops, frame_map);
			anim_map.set(anim.name, anim_data);
		}

		return anim_map;
	}

	public static function parse_anim_frms(frm_list : Array<Dynamic>) : Array<Frame> {
		var frame_list = new Array();

		for (frm in frm_list.iterator()) {
			var cell_list 	= parse_anim_cells(frm.spr);
			var frame_data 	= new Frame(Std.parseInt(frm.index), frm.delay, cell_list);
			frame_list.push(frame_data);
		}

		return frame_list;
	}

	public static function parse_anim_cells(cell_list : Array<Dynamic>) : Array<Cell> {
		var cells = new Array();

		for (cell in cell_list.iterator()) {
			var new_cell = new Cell(cell.name, cell.x, cell.y, cell.z);
			cells.push(new_cell);
		}

		return cells;
	}

	public static function get_data_asset(source : String, file_type : String) : Dynamic {
		var filename 		=  'assets/' + source + '.' + file_type;
		var asset 			= Assets.getText(filename);
		return asset;
	}
}