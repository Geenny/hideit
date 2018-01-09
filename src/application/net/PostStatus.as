package application.net 
{
	/**
	 * ...
	 * @author FKSV
	 */
	public class PostStatus {
		
		public static const DEFAULT:uint = 0;		// Статус при начале отправки
		public static const SENDING:uint = 1;		// Отправка
		public static const SENDED:uint = 2;		// Отправлено
		public static const LOADING:uint = 3;		// Получение данных
		public static const LOADED:uint = 4;		// Данные получены
		public static const ERROR:uint = 5;			// Ошибка при получении данных
		
	}

}