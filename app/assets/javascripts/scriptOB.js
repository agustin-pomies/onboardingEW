document.addEventListener('DOMContentLoaded', function() {
  var checkList = document.getElementsByClassName("check");
  var myModal = document.getElementsByClassName("modal-background")[0];
  for(var i = 0; i < checkList.length; i++) {
    checkList[i].addEventListener('click', wakeModal);
  };
  myModal.addEventListener('click', sleepModal);
});

function wakeModal() {
  if (this.checked) {
    var myModal = document.getElementsByClassName("modal-background")[0];
    myModal.style.display = "block";
  }
}

function sleepModal() {
  var myModal = document.getElementsByClassName("modal-background")[0];
  myModal.style.display = "none";
}

function sortList() {
  var list = document.getElementsByTagName("li");
  var checkList = document.getElementsByClassName("check");
  var j;
  for(var i = 0; i < checkList.length; i++) {
    j = i;
    if(!checkList[i].checked) {
      j++;
      while(j < checkList.length) {
        if(checkList[j].checked) {
          VisualExchange(list[i], list[j]);
          break;
        }
        j++;
      }
    }
  }
}

function VisualExchange(li1, li2) {
  var textAux = li1.innerHTML;
  li1.innerHTML = li2.innerHTML;
  li2.innerHTML = textAux;
  li1.firstChild.childNodes[1].checked = true;
  li2.firstChild.childNodes[1].checked = false;
}
