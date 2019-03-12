JsOsaDAS1.001.00bplist00�Vscripto� l e t   t o d a y   =   n e w   D a t e ( ) ; 
 t o d a y . s e t H o u r s ( 0 , 0 , 0 ) ; 
 l e t   y e s t e r d a y   =   n e w   D a t e ( t o d a y . g e t T i m e ( )   -   2 4 * 6 0 * 6 0 * 1 0 0 0 ) ; 
 
 v a r   o p t i o n s   =   {   w e e k d a y :   ' l o n g ' ,   y e a r :   ' n u m e r i c ' ,   m o n t h :   ' l o n g ' ,   d a y :   ' n u m e r i c '   } ; 
 l e t   n o t e T i t l e   =   ` D a i l y   R e p o r t 	 	 $ { y e s t e r d a y . t o L o c a l e D a t e S t r i n g ( ' z h - C N ' ,   o p t i o n s ) } ` ; 
 
 l e t   t a s k s   =   g e t C o m p l e t e d T a s k s Y e s t e r d a y ( ) ; 
 l e t   n o t e B o d y   =   b u i l d B e a r N o t e B o d y ( t a s k s ) ; 
 
 s a v e T o B e a r ( n o t e T i t l e ,   n o t e B o d y ) ; 
 
 
 f u n c t i o n   g e t C o m p l e t e d T a s k s Y e s t e r d a y ( ) { 
 	 l e t   o m n i f   =   A p p l i c a t i o n ( ' O m n i F o c u s ' ) ; 
 	 r e t u r n   o m n i f . d e f a u l t D o c u m e n t . f l a t t e n e d T a s k s . w h o s e ( { 
 	 	 _ a n d : [ 
 	 	 	 { c o m p l e t e d :   t r u e } , 
 	 	 	 { c o m p l e t i o n D a t e :   { _ g r e a t e r T h a n :   y e s t e r d a y } } , 
 	 	 	 { c o m p l e t i o n D a t e :   { _ l e s s T h a n :   t o d a y } } , 
 	 	 ] 
 	 } ) ; 
 } 
 
 f u n c t i o n   b u i l d B e a r N o t e B o d y ( t a s k s ) { 
 	 l e t   t a g O p t i o n   =   { y e a r :   ' n u m e r i c ' ,   m o n t h :   ' 2 - d i g i t '   } ; 
 	 l e t   n o t e T a g s   =   ` O m n i F o c u s / D a i l y R e p o r t / $ { y e s t e r d a y . t o L o c a l e D a t e S t r i n g ( ' z h - C N ' ,   t a g O p t i o n ) } \ n \ n ` ; 
 	 l e t   c o u n t   =   t a s k s . l e n g t h ; 
 	 v a r   d e s c r i p t i o n   =   " # " +   n o t e T a g s ; 
 	 f o r   ( i   =   0 ;   i   <   c o u n t ;   i + + ) { 
 	 	 d e s c r i p t i o n   + =   b u i l d D e s c r i p t i o n F o r A T a s k ( t a s k s [ i ] ) ; 
 	 } 
 	 r e t u r n   d e s c r i p t i o n ; 
 } 
 
 f u n c t i o n   b u i l d D e s c r i p t i o n F o r A T a s k ( t a s k ) { 
 	 v a r   d e s c r i p t i o n   =   ` +   $ { t a s k . n a m e ( ) } !   $ { t a s k . f l a g g e d ( ) ? '  �=ީ ' : ' ' } \ n ` ; 
 	 i f   ( t a s k . n o t e ( ) )   { 
 	 	 d e s c r i p t i o n   + =   ` >   $ { t a s k . n o t e ( ) . r e p l a c e ( / \ n \ n / g , ' \ n ' ) . r e p l a c e ( / \ n / g , ' \ n >   ' ) } \ n ` ; 
 	 } 
 	 d e s c r i p t i o n   + =   " \ n " ; 
 	 r e t u r n   d e s c r i p t i o n ; 
 } 
 
 f u n c t i o n   s a v e T o B e a r ( t i t l e ,   b o d y ) { 
 	 l e t   s e   =   A p p l i c a t i o n ( ' S y s t e m   E v e n t s ' ) ; 
 	 s e . i n c l u d e S t a n d a r d A d d i t i o n s   =   t r u e ; 
 	 l e t   x c m d   =   ` b e a r : / / x - c a l l b a c k - u r l / c r e a t e ? t i t l e = $ { e n c o d e U R I C o m p o n e n t ( t i t l e ) } & t e x t = $ { e n c o d e U R I C o m p o n e n t ( b o d y ) } ` ; 
 	 s e . o p e n L o c a t i o n ( x c m d ) ; 
 }                              �jscr  ��ޭ