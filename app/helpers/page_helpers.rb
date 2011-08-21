class Main
  module PageHelpers
    def body_class(v = nil)
      @body_classes ||= []
      @body_classes << v  if v

      @body_classes.join(' ')
    end

    def title(title=nil)
      @page_title = title  if title
      @page_title
    end

    def checkbox(id, value=nil)
      checked = value ? " checked='1'" : ''

      "<input type='hidden' name='#{id}' value='0' />" +
      "<input type='checkbox' name='#{id}' value='1'#{checked} />"
    end

    def checked_if(condition)
      condition ? { :checked => '1' } : Hash.new
    end
  end

  helpers PageHelpers
end
