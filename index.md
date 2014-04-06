---
title: A blog about Mathematics, R, Statistics, ...
---

<script type='text/x-mathjax-config'>
  MathJax.Hub.Config({
  TeX: {
    Macros: {
      indic: "{\\bf 1}",
      perpoplus: "\\overset{\\perp}{\\oplus}",
      RR: "\\mathbb{R}"
    }
  }
  });
</script>

<style>
ul.posts {
  margin-top: 15px;
}
ul.posts li {
  list-style: none
}
ul.posts hr {
  margin: 5px 5px;
}
ul.posts span {
  font-size: 12px;
  color: #999;
}
</style>

<ul class="posts">
{{# pages }}
 {{# date }}
 <li>
  <span class='pull-right'>{{date}}</span> 
  <a href="{{site.url}}{{link}}">{{{ title }}}</a>
  <hr/>
 </li>
 {{/ date }}
{{/ pages }}
</ul>


