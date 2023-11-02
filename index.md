---
layout: default
---

<table>

<tr>
  <th class="druid">DRUID</th>
  <th class="title">Title</th>
  <th class="collection">Collection</th>
  <th class="files">Files</th>
  <th class="size">Size</th>
</tr>

{% for item in site.data.items %}
<tr class="item">
  <td class="druid"><a href="https://purl.stanford.edu/{{ item.druid }}">{{ item.druid }}</a></td>
  <td class="title"><a href="{{ site.baseurl }}/items/{{ item.druid }}/">{{ item.title }}</a></td>
  <td class="collection">{{ item.collection }}</td>
  <td class="files">{{ item.shelved_files }}</td>
  <td class="size">{{ item.preservation_size }}</td>
</tr>
{% endfor %}

</table>
