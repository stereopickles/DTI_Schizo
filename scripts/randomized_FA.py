#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jan 15 10:51:16 2021

@author: Eunjoo Byeon

A script to copy over existing files and rename them to 
new numbers and generate a key reference of old-new name match

"""

import re
import os
from shutil import copy2
import numpy as np

def find_files(list_of_dir, dir_word = 'sub', file_word = 'FA', file_type = 'nii'):
    ''' 
    from the list of directories
    find sub-directories starting with the dir_word
    within these sub-directories, 
    get a list of files (full path) conatining the file_word
    ''' 
    paths = []
    for dir_ in list_of_dir: 
        path_ = [x[0] for x in os.walk(dir_) if x[0].startswith(dir_word)]
        full_path = os.join(dir_, path_)
        paths.append(full_path)
        
    full_paths = []
    for fp in paths:
        fnames = [x for x in os.listdir(fp) if file_word in x and x.endswith(file_type)]
        full_path = os.join(fp, fnames)
        full_paths.join(full_path)
        
    return full_paths
        

def copy_files(full_paths, new_path): 
    ''' 
    copy over all file from a list to the new path
    '''
    for fp in full_paths:
        copy2(fp, new_path)
 

def random_assignment(fpath):
    ''' 
    extract the current subject number from file path
    assign a new number, 
    return a dictionary of old/new
    '''
    paths = os.listdir(fpath)
    keys = [re.findall('(?<=A)[0-9]*', x) for x in paths]
    new_keys = [str(x) for x in np.random.permutation(1000)[:len(keys)]]    
    old = tuple(zip(keys, paths))
    ref = dict(zip(new_keys, old))
    return ref


def rename_files(fpath, old_name, new_name):
    os.rename(os.join(fpath, old_name), os.join(fpath, new_name))


def rand_assignment_processing(fpath):
    '''
    take a directory then rename all files 
    and return the dictionary of old-new file name references
    '''
    ref = random_assignment(fpath)
    
    for k in ref.keys(): 
        old_fn = 
        new_fn = 
        rename_files(fpath, old, new)
    
    return ref

list_of_dir = []
new_dir = None
full_paths = find_files(list_of_dir)
copy_files(full_paths, new_dir)
ref = rand_assignment_processing(new_dir)

