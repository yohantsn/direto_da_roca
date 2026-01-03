abstract class AuthExceptions implements Exception {}

class UserNotFoundException extends AuthExceptions {}

class UserAlreadyExistsException extends AuthExceptions {}

class PasswordWeakException extends AuthExceptions {}

class EmailInvalidException extends AuthExceptions {}

class OtherException extends AuthExceptions {}
