import math

# import functions from math, that np doesn't have
from math import factorial
from math import gcd
from math import comb
from math import comb as binomialcoef

from numpy import *

# prefer the normal sum() over the numpy version
del globals()["sum"]

# this is for e.g. "np.max" which is not imported by default
import numpy as np

# prefer math.log over np.log because with math.log it is possible to
# define a custom base - which is not possible with np
from math import log
