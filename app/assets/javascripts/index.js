/* List.js is required to make this table work. */
var pagingRows = 6;

var paginationOptions = {
    innerWindow: 1,
    left: 0,
    right: 0
};
var options = {
  valueNames: [ 'pickupTime', 'pickupName', 'pickupID' ],
  page: pagingRows,
  plugins: [ ListPagination(paginationOptions) ],
};

var tableList = new List('tableID', options);

$('.jTablePageNext').on('click', function(){
    var list = $('.pagination').find('li');
    $.each(list, function(position, element){
        if($(element).is('.active')){
            $(list[position+1]).trigger('click');
        }
    })
})
$('.jTablePagePrev').on('click', function(){
    var list = $('.pagination').find('li');
    $.each(list, function(position, element){
        if($(element).is('.active')){
            $(list[position-1]).trigger('click');
        }
    })
})


