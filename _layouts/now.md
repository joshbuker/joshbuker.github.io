---
layout: default
# Now page
---
{%- include multi_lng/get-lng-by-url.liquid -%}
{%- assign lng = get_lng -%}
<div class="row">
  <div class="col-md-12">
    {{ content }}
  </div>
</div>
