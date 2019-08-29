class Validation {
  //username validator
  String validateUsername(String value) {
    if (value.length == 0) {
      return 'Fill in this field';
    } else if (value.length <= 4) {
      return 'Incorrect username';
    } else {
      return null;
    }
  }

  //password validator
  String validatePassword(String value) {
    if (value.length == 0) {
      return 'Fill in this field';
    } else if (value.length <= 4) {
      return 'Password too short';
    } else {
      return null;
    }
  }
}
