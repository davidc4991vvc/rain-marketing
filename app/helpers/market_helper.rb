module MarketHelper
  include ApplicationHelper
  
  BADGE_FLAG = {'success' => '成功', 'error' => '错误', 'warning' => '警告', 'important' => '严重', 'info' => '提示', 'inverse' => '失败'}
  def rand_flag
    BADGE_FLAG.keys[rand(5)]
  end
  #On admin page title, e.g. /home/sms
  # <%= page_header('短信通', {'发送日志' => '/phone_items',}) %>
  def page_header(title, opts = {})
    arr = []
    arr << %{
      <div class='row'>
        <div class='col-sm-12'>
          <div class='page-header'>
            <h1 class='pull-left'>
              <i class='icon-table'></i>
              <span>#{title}</span>
            </h1>
            <div class='pull-right'>
              <ul class='breadcrumb'>}
                opts.each_pair do |k, v|
                  if k =~ /返回|控制面板/
                    arr << link_to(k, v, :class=> 'btn btn-white') 
                  else
                    arr << link_to(k, v, :class=> 'btn btn-primary')
                  end
                end
     arr << %{</ul>
            </div>
          </div>
        </div>
      </div>}
    arr.join.html_safe
  end

  # <%= box_title('日志查看') %>
  def box_title(title, color = 'blue')
    %{
      <div class="box-header #{color}-background">
          <div class="title">#{title}</div>
          <div class="actions">
              <a href="#" class="btn box-collapse btn-mini btn-link"><i></i>
              </a>
          </div>
      </div>
    }.html_safe
  end
  
  #flash动画显示
  # eg: play_flash("flash/top_banner.swf")
  # or: play_flash asset_path("flash/top_banner.swf"), :width => '985', :height => '249'
  def play_flash(src, options = {:width=>'600', :height=>'400'})
    str = "<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' width='"+ options[:width] +"' height='"+ options[:height] +"' id='FlashID' accesskey='1' tabindex='1' title='daiii'>
        <param name='movie' value='" + src + "' />
        <param name='quality' value='high' />
        <param name='wmode' value='transparent' />
        <param name='swfversion' value='9.0.45.0' />
        <!--[if !IE]>-->
        <object type='application/x-shockwave-flash' data='" + src + "' width='"+  options[:width] +"' height='"+  options[:height] +"'>
          <!--<![endif]-->
          <param name='movie' value='" + src + "' />
          <param name='quality' value='high' />
          <param name='wmode' value='transparent' />
          <param name='swfversion' value='9.0.45.0' />
          <div>
            <h4>Plsease update Adobe Flash Player。</h4>
          </div>
          <!--[if !IE]>-->
        </object>
        <!--<![endif]-->
      </object>"
    return str.html_safe
  end

end
