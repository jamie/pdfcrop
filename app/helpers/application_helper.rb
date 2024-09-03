module ApplicationHelper
  def labelled_range(name, label, range, default, step: 1)
    <<~HTML.html_safe
      <div class="range-slider" data-controller="range-slider">
        <label for="#{name}">#{label}</label>
        <br />
        <input type="range"
              name="#{name}"
              class="form-range"
              data-range-slider-target="range"
              data-action="input->range-slider#updateValue"
              value="#{default}"
              min="#{range.begin}"
              max="#{range.end}"
              step="#{step}">
        <output data-range-slider-target="value">#{default}</output>
      </div>
    HTML
  end
end
