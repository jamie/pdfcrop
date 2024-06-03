module ApplicationHelper
  def labelled_range(name, label, range, default)
    <<~HTML.html_safe
    <div>
      <label for="#{name}" class="form-label">#{label}</label>
      <input type="range" id="#{name}" name="#{name}" class="form-range" min="#{range.begin}" max="#{range.end}" value="#{default}" />
    </div>
    HTML
  end
end
