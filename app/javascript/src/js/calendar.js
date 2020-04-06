(function($){
  var class_td = 'mycld_td'
  $(document).on('click','.'+class_td,function(){
    $(this).data("flag", $(this).data("flag") === 'on' ? "off" : "on")
    $(this).toggleClass('td_check')
    getDate()
  })

  var getDate = function(){
    var $div = $("#calendar")
    let ary_date = []
    $div.find("td").each(function(){
      var flag = $(this).data('flag')
      if( flag === 'on' && $(this).text() ){
        ary_date.push($(this).attr('id').replace("mycld_", ""))
      }
    })
    $("#days").val(ary_date.join(','))
  }
})(jQuery)
