enum Gender{MALE,FEMALE,NON}
extension ToString on Gender{
  String toName(){
    return this.toString().split(".").last;
  }
}