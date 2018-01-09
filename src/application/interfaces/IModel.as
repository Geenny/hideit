package application.interfaces 
{
	
	/**
	 * ...
	 * @author FKSV
	 */
	public interface IModel {
		
		/**
		 * Сырые данные
		 */
		function get data():Object;
		
		/**
		 * Обработка сырых данных
		 */
		function parse(data:Object):void;
		
	}
	
}