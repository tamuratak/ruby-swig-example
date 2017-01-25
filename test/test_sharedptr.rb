
def t
  a = Mylib::Sharedptr::A.new(2.0)
  p a
  b = Mylib::Sharedptr::B.new(a)
end
b = t()
GC.start #=> Ruby level A destroyed here

p a = b.get_a
p a.get_m

# exit
#=> Ruby level A destroyed again
#=> C++ level A destroyed 
