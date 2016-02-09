namespace tpl {
  template <class T>
  class A {
  public:
    A(const T &t) : m_t(t) {};
  private:
    T m_t;
  };
}
