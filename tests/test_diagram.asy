
settings.outformat="pdf";
unitsize(1cm);

real node_scale       = 0.18;
real stretch          = 1;
real node_label_scale = 0.6;
real edge_label_scale = 0.4;



void simpleArrow(real x, real y, string f, string i, string j) {
  real r = node_scale;
  real s = stretch;
  real y = y  - node_scale;

  draw(circle((x,y),node_scale) , black);
  label(scale(node_label_scale)*f, (x,y));

  draw((x,y+r+s)--(x,y+r));
  label(scale(edge_label_scale)*i,(x,y+r+0.5*s),E);

  draw((x,y-r)--(x,y-r-s+0.14));
  label(scale(edge_label_scale)*j,(x,y-r-0.5*s),E);
}


void forkPath(real x, real xoff, real y, string i) {
  real r    = node_scale;
  real s    = stretch;
  real xmid = (2*x+xoff)/2;
  real y_op = y-r-2*s;
  string op = "@";

  draw(circle((xmid,y),r), black);
  label(scale(node_label_scale)*op,(xmid,y));
  label(scale(edge_label_scale)*i,(xmid,y+r+0.5*s),E);

  path p_left  = (xmid+r*cos(pi * 7/6) , y+r*sin(pi * 7/6)){curl 0} ..
        	 {down}(x,y-r-s+node_scale);
  path p_right = (xmid+r*cos(pi * 11/6) , y+r*sin(pi * 11/6)){curl 0} ..
        	 {down}(x+xoff,y-r-s+node_scale);

  draw(p_left); draw(p_right);
  draw((xmid,y+r+s)--(xmid,y+r));

  //-- an alternative style
  //path pl_1 = (xmid,y){down} .. {left}(xmid-0.4*s, y-0.5*s);
  //path pl_2 = (xmid-0.4*s, y-0.5*s)..(x+0.4*s, y-0.5*s);
  //path pl_3 = (x+0.4*s, y-0.5*s){left} .. {down}(x, y-s);
  //path pr_1 = (xmid,y){down} .. {right}(xmid+0.4*s, y-0.5*s);
  //path pr_2 = (xmid+0.4*s, y-0.5*s)..(x+xoff-0.4*s, y-0.5*s);
  //path pr_3 = (x+xoff-0.4*s, y-0.5*s){right} .. {down}(x+xoff, y-s);
  //draw(pl_1); draw(pl_2); draw(pl_3);
  //draw(pr_1); draw(pr_2); draw(pr_3);

}


void compose(real x, real y, string f, string g, string i, string j, string k) {
  simpleArrow(x , y         , f,  i, j);
  simpleArrow(x , y-2*stretch , g, "", k);
}


void coproduct( real x, real xoff, real y, string t3) {
  real r    = node_scale;
  real s    = stretch;
  real x_op = (2*x+xoff)/2;
  real y_op = y-r-2*s;
  string op = "$\oplus$";

  draw(circle((x_op,y_op),r), black);
  label(scale(node_label_scale)*op,(x_op,y_op));
  label(scale(edge_label_scale)*t3,(x_op,y_op-r-0.5*s),E);

  path p_left  = (x,y-r-s){down} ..
                 ((x_op+r*cos(pi * 5/6)+x)*0.5 , (y_op+r*sin(pi * 5/6)+y-r-s)*0.5) ..
		 (x_op+r*cos(pi * 5/6) , y_op+r*sin(pi * 5/6));
  path p_right = (x+xoff,y-r-s){down} ..
                 ((x_op+r*cos(pi * 1/6)+x+xoff)*0.5 , (y_op+r*sin(pi * 1/6)+y-r-s)*0.5) ..
		 (x_op+r*cos(pi * 1/6)  , y_op+r*sin(pi * 1/6));

  draw(p_left); draw(p_right);
  draw((x_op,y_op-r)--(x_op,y_op-r-s+node_scale));
}


void product( real x, real xoff, real y, string t2, string t3) {
  real r     = node_scale;
  real s     = stretch;
  real x_op  = (2*x+xoff)/2;
  real y_op  = y-r-2*s;
  string op  = "$\otimes$";
  string res = t2+"$\times$"+t3;

  draw(circle((x_op,y_op),r), black);
  label(scale(node_label_scale)*op,(x_op,y_op));
  label(scale(edge_label_scale)*res,(x_op,y_op-r-0.5*s),E);

  path p_left  = (x,y-r-s){down} ..
                 ((x_op+r*cos(pi * 5/6)+x)*0.5 , (y_op+r*sin(pi * 5/6)+y-r-s)*0.5) ..
		 (x_op+r*cos(pi * 5/6) , y_op+r*sin(pi * 5/6));
  path p_right = (x+xoff,y-r-s){down} ..
                 ((x_op+r*cos(pi * 1/6)+x+xoff)*0.5 , (y_op+r*sin(pi * 1/6)+y-r-s)*0.5) ..
		 (x_op+r*cos(pi * 1/6)  , y_op+r*sin(pi * 1/6));

  draw(p_left); draw(p_right);
  draw((x_op,y_op-r)--(x_op,y_op-r-s+node_scale));
}



// Axis
draw((0,0)--(0,-20), arrow=ArcArrow());
draw((0,0)--(20,0), arrow=ArcArrow());

// Column locations
real c1 = 2;
real c2 = 4;
real c3 = 6;
real c4 = 10;

// args : x0, y0, node scale, stretch, f-label, g-label, t1, t2, t3
compose(c1, -1, "$f$", "$g$", "$a$", "$b$", "$c$");
compose(c2, -1, "$f$", "$f^{\dag}$", "$a$", "$b$", "$a$");

simpleArrow(c3  , -1, "$f$", "$a$", "$c$");
simpleArrow(c3+2, -1, "$g$", "$b$", "$c$");
coproduct(c3, 2, -1, "$c$");

// args : x0, x-offset, y0, node scale, stretch, f-label, g-label, t1, t2, t3
simpleArrow(c4   , -1, "$f$", "$a$", "$b$");
simpleArrow(c4+2 , -1, "$g$", "$a$", "$c$");
product(c4, 2, -1, "$b$", "$c$");

product(c2, 3, -3, "$a$", "$c$");


forkPath(c1, 2, -6, "$a$");
simpleArrow(c1   , -8, "$f$", "$a$", "$b$");
simpleArrow(c1+2 , -8, "$g$", "$a$", "$c$");
product(c1, 2, -8, "$b$", "$c$");


