<div>
  <div class="me">
    <div>
      <svg viewBox="0 0 821 821" width="821" height="821" version="1.2"><path fill="#372C26" d="M0 0h820v820H0z"></path><path fill="#FFFFF4" fill-opacity=".5" d="M242 286l374 1-190-172z"></path><path fill="#FFEAC6" fill-opacity=".5" d="M200 367l372-38-19 210z"></path><path fill="#FFF" fill-opacity=".5" d="M497 626l323 194H336z"></path><path fill="#BBD0E1" fill-opacity=".5" d="M621 692L349 820l471-33z"></path><path fill-opacity=".5" d="M820 0H0l820 307z"></path><path fill="#BAD3EC" fill-opacity=".5" d="M1 732l-1 88h321z"></path><path fill="#FFBF97" fill-opacity=".5" d="M569 510l-284-6 122 128z"></path><path fill="#040000" fill-opacity=".5" d="M351 520l103-86-86-24z"></path><path fill="#FFE3C2" fill-opacity=".5" d="M284 176l139 175 136-176z"></path><path fill="#FFD7C1" fill-opacity=".5" d="M318 332l287 48-20 112z"></path><path fill="#CB764E" fill-opacity=".5" d="M434 133l-155 51-36 173z"></path><path fill="#FFCFB5" fill-opacity=".5" d="M335 161l237 181-19-145z"></path><path fill-opacity=".5" d="M0 750V0l400 665zM820 819V0L546 298z"></path><path fill="#520000" fill-opacity=".5" d="M501 485l-105 6 111 25z"></path><path fill-opacity=".5" d="M751 0L523 656l297 120z"></path><path fill="#6B2100" fill-opacity=".5" d="M431 730l-96 90-164-13z"></path><path fill="#F4BDA9" fill-opacity=".5" d="M384 494l112 22-31 103z"></path><path fill="#F6B79A" fill-opacity=".5" d="M406 169l164 70-78-83z"></path><path fill-opacity=".5" d="M403 0L0 770V0z"></path><path fill="#3A0500" fill-opacity=".5" d="M289 820l-60-252 279 57z"></path><path fill="#FFAD9D" fill-opacity=".5" d="M416 469l50 23-83-10z"></path><path fill="#FFD5AD" fill-opacity=".5" d="M547 820H386l139-247z"></path><path fill="#FFC3AC" fill-opacity=".5" d="M596 458l-4-118-34 154z"></path><path fill="#96BCDB" fill-opacity=".5" d="M415 820h405v-41z"></path><path fill="#CD8C6C" fill-opacity=".5" d="M511 283l55 116 6-164z"></path><path fill-opacity=".5" d="M820 0L416 164 0 1z"></path><path fill="#FFAD8E" fill-opacity=".5" d="M422 371l-168-30 55 150z"></path><path fill="#360000" fill-opacity=".5" d="M287 279l116 101-7-98z"></path><path fill="#BB815C" fill-opacity=".5" d="M404 817l-82 3 148-163z"></path><path fill="#FFBFAA" fill-opacity=".5" d="M461 463l-92-220 154 186z"></path><path fill="#758697" fill-opacity=".5" d="M246 820l-119-99L1 753z"></path><path fill="#D99E81" fill-opacity=".5" d="M438 305l-182-57 32-63z"></path><path fill="#FFDBC9" fill-opacity=".5" d="M391 395l35 41 21-63z"></path><path fill="#FCD0C0" fill-opacity=".5" d="M401 342l26 86 25-267z"></path><path fill="#200" fill-opacity=".5" d="M448 343l-7-49 122 46z"></path><path fill="#7D3F1F" fill-opacity=".5" d="M349 513l-61 65 169-24z"></path><path fill="#FFE1BD" fill-opacity=".5" d="M536 667l-28 127 60-101z"></path><path fill="#754427" fill-opacity=".5" d="M438 533l-162 4 132 30z"></path><path fill="#A5573A" fill-opacity=".5" d="M515 278l-74 33-68-11z"></path><path fill="#7D340D" fill-opacity=".5" d="M191 435l181 190-123-304z"></path><path fill="#F8D2C3" fill-opacity=".5" d="M376 354l-37 76-59-65z"></path><path fill="#F7C5AE" fill-opacity=".5" d="M465 559l-26 43-113-26z"></path><path fill="#3E0000" fill-opacity=".5" d="M344 518l74-53-38-110z"></path><path fill="#FFDACB" fill-opacity=".5" d="M452 375l76 58 39-87z"></path><path fill-opacity=".5" d="M237 402L0 12 312 1zM497 565l323 223V230z"></path><path fill-opacity=".5" d="M820 509V0H372z"></path><path fill="#1D0700" fill-opacity=".5" d="M366 793l-33-110 192-112z"></path></svg>
      <img src="https://res.cloudinary.com/jmperez/image/upload/w_240,f_auto,c_scale/v1519156883/profile_ysrm5y.jpg" style="border-radius:100%" alt="José M. Pérez" sizes="120px" width="120" height="120">
    </div>
    <h1>José M. Pérez</h1>
    <p>Engineer at Facebook and <abbr title="Google Developer Expert">GDE</abbr> in Web Technologies. Ex Spotify.
  </div>
</div>
<div class="row posts-list">
 {% for post in page.posts %}
  {% if post.lang == 'en' %}
   <div class="wrapper">
     <div class="post">
       <a href="{{ url_for(post.path) }}">
         <h2>{{ post.title }}</h2>
       </a>
       {% if post.excerpt %}
       {{ post.excerpt }}
        <div class="post-data">
          <a class="button" href="{{ url_for(post.path) }}">Continue reading <span class="outscreen"> about {{ post.title }}</span>...</a>
        </div>
      {% endif %}
     </div>
   </div>
  {% endif %}
  {% endfor %}
  {{ partial('_partial/pagination')}}
</div>
