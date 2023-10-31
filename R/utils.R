ensure_directory <- function(directory){
  if(!dir.exists(directory)) {
    dir.create(directory);
  }
}
