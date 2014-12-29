# data analysis

# %stats
@register_line_magic
def stats(line):
    _ip.run_code("import scipy.stats as stats")


del stats
