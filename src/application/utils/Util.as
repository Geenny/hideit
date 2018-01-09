package application.utils 
{
	/**
	 * ...
	 * @author FKSV
	 */
	public class Util 
	{
		
		/**
		 * Объеденение объектов. Создает поля при их отсутствии
		 * @param	fromObject
		 * @param	toObject
		 * @return
		 */
		public static function concatObjects(fromObject:Object, toObject:Object = null):Object {
			
			const OBJECT:String = "object";
			
			// Создать, если нет исходного объекта
			if (!toObject) toObject = { };
			
			// Замещение данных при несоответствии
			if (fromObject) {
				for (var key:* in fromObject) {
					if (typeof fromObject[key] == OBJECT) {
						toObject[key] = concatObjects(fromObject[key], toObject[key]);
					}else if (toObject[key] != fromObject[key]) {
						toObject[key] = fromObject[key];
					}
				}
			}
			
			return toObject;
		}
		
		
		/**
		 * Переназначить поля из @fromObject в типизированный но неизвестный @typecalInstance
		 * @param	typecalInstance
		 * @param	fromObject
		 * @return
		 */
		public static function concatToTypecalInstance(typecalInstance:*, fromObject:Object = null):* {
			if (!fromObject) return;
			for (var key:* in fromObject) {
				if (!typecalInstance.hasOwnProperty(key)) continue;
				typecalInstance[key] = fromObject[key];
			}
		}
		
		
		/**
		 * Подсчет объектов
		 * @param	object
		 * @return
		 */
		public static function countProperties(object:Object):uint {
			var count:uint = 0;
			if (object) {
				for each(var value:* in object)
					count ++;
			}
			return count;
		}
		
	}

}