JsOsaDAS1.001.00bplist00�Vscripto	� / *   T i m e   S p a n   S T A R T 
 Y o u   c a n   m o d i f y   t h e   c o d e   t o   m a k e   w e e k l y   r e p o r t ,   M o n t h l y   r e p o r t . 
 * / 
 l e t   t o d a y   =   n e w   D a t e ( ) ; 
 t o d a y . s e t H o u r s ( 0 ,   0 ,   0 ) ; 
 l e t   y e s t e r d a y   =   n e w   D a t e ( ) ; 
 y e s t e r d a y . s e t D a t e ( n e w   D a t e ( ) . g e t D a t e ( )   -   1 ) ; 
 y e s t e r d a y . s e t H o u r s ( 0 ,   0 ,   0 ) ; 
 / /   T i m e   S p a n   E N D 
 
 / /   C o n f i g u r a t i o n   S T A R T 
 l e t   c f g   =   { 
         k e e p N o t e s :   t r u e ,   / /   K e e p s   n o t e s ,   o r   n o t . 
         d a t e L o c a l e :   " e n - U S " ,   / /   U s e   z h - C N   f o r   C h i n e s e 
         c o m p a c t V i e w M o d e :   f a l s e ,   / /   I f   t u r e ,   t h e r e ' s   n o   e m p t y   l i n e   b e t w e e n   e n t r i e s . 
 
         d a t e B e g i n :   y e s t e r d a y , 
         d a t e E n d :   t o d a y , 
 } ; 
 / /   C o n f i g u r a t i o n   E N D 
 
 
 / *   T a g s   w i l l   b e   d i s p l a y   i n   t h e   f i r s t   l i n e   o f   t h e   n o t e   b o d y ,   j u s t   b e l o w   t h e   t i t l e . * / 
 / /   l e t   n o t e T a g s   =   " # D a i l y   R e p o r t #   # O m n i F o c u s " ;   / /   S t a t i c   t a g s 
 l e t   t a g D a t e O p t i o n s   =   {   y e a r :   ' n u m e r i c ' ,   m o n t h :   ' 2 - d i g i t '   } ; 
 l e t   n o t e T a g s   =   ` # O m n i F o c u s / D a i l y R e p o r t / $ { c f g . d a t e B e g i n . t o L o c a l e D a t e S t r i n g ( c f g . d a t e L o c a l e ,   t a g D a t e O p t i o n s ) } ` ;   / /   U s e   d y n a m i c   t a g s   g r o u p   b y   m o n t h . 
 
 l e t   d a t e O p t i o n s   =   {   w e e k d a y :   ' l o n g ' ,   y e a r :   ' n u m e r i c ' ,   m o n t h :   ' l o n g ' ,   d a y :   ' n u m e r i c '   } ; 
 l e t   n o t e T i t l e   =   ` D a i l y   R e p o r t               $ { c f g . d a t e B e g i n . t o L o c a l e D a t e S t r i n g ( c f g . d a t e L o c a l e ,   d a t e O p t i o n s ) } ` ; 
 
 l e t   n o t e B o d y   =   b u i l d B e a r N o t e B o d y ( ) ; 
 
 s a v e T o B e a r ( n o t e T i t l e ,   n o t e T a g s ,   n o t e B o d y ) ; 
 
 f u n c t i o n   g e t C o m p l e t e d T a s k s ( )   { 
         l e t   o m n i D o c   =   A p p l i c a t i o n ( ' O m n i F o c u s ' ) . d e f a u l t D o c u m e n t ; 
         r e t u r n   o m n i D o c . f l a t t e n e d T a s k s . w h o s e ( { 
                 _ a n d :   [ 
                         {   c o m p l e t e d :   t r u e   } , 
                         {   c o m p l e t i o n D a t e :   {   _ g r e a t e r T h a n :   c f g . d a t e B e g i n   }   } , 
                         {   c o m p l e t i o n D a t e :   {   _ l e s s T h a n :   c f g . d a t e E n d   }   } , 
                 ] 
         } ) ( ) . m a p ( t a s k   = >   { 
                 r e t u r n   { 
                         n a m e :   t a s k . n a m e ( ) , 
                         n o t e :   t a s k . n o t e ( ) . t r i m ( ) , 
                         f l a g g e d :   t a s k . f l a g g e d ( ) , 
                 } ; 
         } ) ; 
 } 
 
 f u n c t i o n   b u i l d B e a r N o t e B o d y ( )   { 
         l e t   t a s k s   =   g e t C o m p l e t e d T a s k s ( ) ; 
         l e t   c o u n t   =   t a s k s . l e n g t h ; 
         v a r   d e s c r i p t i o n   =   " " ; 
         f o r   ( i   =   0 ;   i   <   c o u n t ;   i + + )   { 
                 d e s c r i p t i o n   + =   b u i l d D e s c r i p t i o n F o r A T a s k ( t a s k s [ i ] ) ; 
         } 
         r e t u r n   d e s c r i p t i o n ; 
 } 
 
 f u n c t i o n   b u i l d D e s c r i p t i o n F o r A T a s k ( t a s k )   { 
         v a r   d e s c r i p t i o n   =   ` +   $ { t a s k . n a m e } !   $ { t a s k . f l a g g e d ? '  �=ީ ' : ' ' } \ n ` ; 
         i f   ( c f g . k e e p N o t e s   & &   t a s k . n o t e   ! =   " " )   { 
                 d e s c r i p t i o n   + =   ` >   $ { t a s k . n o t e . r e p l a c e ( / \ n \ n / g , ' \ n ' ) . r e p l a c e ( / \ n / g , ' \ n >   ' ) } \ n ` ; 
         } 
         i f   ( ! c f g . c o m p a c t V i e w M o d e )   { 
                 d e s c r i p t i o n   + =   " \ n " ; 
         } 
         r e t u r n   d e s c r i p t i o n ; 
 } 
 
 f u n c t i o n   s a v e T o B e a r ( t i t l e ,   t a g s ,   b o d y )   { 
         l e t   s e   =   A p p l i c a t i o n ( ' S y s t e m   E v e n t s ' ) ; 
         s e . i n c l u d e S t a n d a r d A d d i t i o n s   =   t r u e ; 
         l e t   t a g s A n d B o d y   =   t a g s   +   " \ n \ n "   +   b o d y ; 
         l e t   x c m d   =   ` b e a r : / / x - c a l l b a c k - u r l / c r e a t e ? t i t l e = $ { e n c o d e U R I C o m p o n e n t ( t i t l e ) } & t e x t = $ { e n c o d e U R I C o m p o n e n t ( t a g s A n d B o d y ) } ` ; 
         s e . o p e n L o c a t i o n ( x c m d ) ; 
 }                              
jscr  ��ޭ