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

def find_files(list_of_dir, dir_word = 'sub', file_word = 'FA'):
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
        fnames = [x for x in os.listdir(fp) if file_word in x]
        full_path = os.join(fp, fnames)
        full_paths.join(full_path)
        
    return full_paths
        

def copy_files(fpath, new_path): 
    ''' copy over a file to the new path '''
    pass
 


def random_assignment(fpath):
    ''' 
    extract the current subject number, 
    assign a new number, 
    return a dictionary of old/new
    '''
    pass

def rename_files(fpath, old_name, new_name):
    pass


def rand_assignment_processing():
    '''
    take a directory then rename all files 
    and return the dictionary of old-new file name references
    '''
    ref = random_assignment(fpath)
    for old, new in ref: 
        rename_files(fpath, old, new)
    
    return ref
