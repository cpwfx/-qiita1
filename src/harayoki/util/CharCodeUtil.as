package harayoki.util {
	public class CharCodeUtil {

		private static var _workVector:Vector.<int> = new <int>[];
		private static var _ASCII_RANGE:Vector.<int>;

		/**
		 * 文字コード一覧を文字指定範囲から返す
		 * @param charFrom 最初の文字列
		 * @param charTo 最後の文字列
		 * @param out 結果を（追加で）格納するVector
		 */
		public static function getIdListByCharRange(charFrom:String, charTo:String = null, out:Vector.<int> = null):Vector.<int> {
			if (charFrom == null || charFrom.length == 0) {
				return out;
			}
			if (charTo == null || charTo.length == 0) {
				charTo = charFrom;
			}
			return getIdListByCodeRange(charFrom.charCodeAt(0), charTo.charCodeAt(0));
		}

		/**
		 * 文字コード一覧を文字一覧から返す
		 * @param letters 文字列
		 * @param out 結果を（追加で）格納するVector
		 */
		public static function getIdListByLetters(letters:String, out:Vector.<int> = null):Vector.<int> {
			if (!out) {
				out = new <int>[];
			}
			_workVector.length = 0;
			var i:int = letters.length;
			while(i--) {
				var code:int = letters.charCodeAt(i);
				// 重複をはぶいて一覧に追加
				if(_workVector.indexOf(code) == -1) {
					out.push(code);
				}
				_workVector.push(code)
			}
			return out;
		}

		/**
		 * 文字コード一覧を文字コード指定範囲から返す
		 * @param idFrom 最初の文字コード
		 * @param idTo 最後の文字コード
		 * @param out 結果を（追加で）格納するVector
		 */
		public static function getIdListByCodeRange(idFrom:int, idTo:int = -1, out:Vector.<int> = null):Vector.<int> {
			if (!out) {
				out = new <int>[];
			}
			for (var i:int = idFrom; i <= idTo; i++) {
				out.push(i);
			}
			return out;
		}

		/**
		 * ASCII範囲の文字コード一覧を返す
		 */
		public static function getIdListForAscii():Vector.<int> {
			if(!_ASCII_RANGE) {
				_ASCII_RANGE = getIdListByCodeRange(32, 126); // ' ' から '~'
				_ASCII_RANGE.fixed = true;
			}
			return _ASCII_RANGE;
		}

	}
}
